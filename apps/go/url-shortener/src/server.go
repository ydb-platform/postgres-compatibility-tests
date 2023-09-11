package main

import (
	_ "embed"
	"errors"
	"fmt"
	ginzap "github.com/gin-contrib/zap"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"html/template"
	"net/http"
	"net/url"
	"path"
	"time"
)

var (
	//go:embed templates/page_template.html
	pageTemplateText string
)

var (
	pageTemplate = template.Must(template.New("page").Parse(pageTemplateText))
)

type pageTemplateData struct {
	SourceURL string
	TargetURL string
	Error     string
}

type Handler struct {
	storage Storage
	gin     *gin.Engine
}

func NewHandler(logger *zap.Logger, storage Storage) *Handler {
	handler := &Handler{
		storage: storage,
		gin:     gin.New(),
	}

	handler.gin.Use(
		RequestIDMiddleware(logger),
		ginzap.Ginzap(logger, time.RFC3339, false),
		ginzap.RecoveryWithZap(logger, true),
	)

	handler.gin.Handle(http.MethodGet, "/", handler.mainPage)
	handler.gin.Handle(http.MethodGet, "/r/:id", handler.redirect)
	handler.gin.Handle(http.MethodPost, "/", handler.addURL)

	return handler
}

func (s *Handler) ServeHTTP(writer http.ResponseWriter, request *http.Request) {
	s.gin.ServeHTTP(writer, request)
}

func (s *Handler) mainPage(ctx *gin.Context) {
	logger := s.logger(ctx)
	err := pageTemplate.Execute(ctx.Writer, nil)
	if err != nil {
		logger.Warn("failed to execute template", zap.Error(err))
		ctx.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	logger.Debug("OK")
}

func (s *Handler) logger(ctx *gin.Context) *zap.Logger {
	val, ok := ctx.Get("logger")
	if ok {
		return val.(*zap.Logger)
	}
	return zap.NewNop()
}

func (s *Handler) redirect(ctx *gin.Context) {
	logger := s.logger(ctx)
	id := ctx.Param("id")
	targetURL, err := s.storage.GetURL(ctx, id)
	switch {
	case errors.Is(err, ErrNotFound):
		logger.Debug("url id not found", zap.Error(err), zap.String("id", id))
		s.errorPage(ctx, http.StatusNotFound, fmt.Sprintf("not found short id: %q", id))
		return
	case err != nil:
		logger.Debug("internal error during request", zap.Error(err), zap.String("id", id))
		s.errorPage(ctx, http.StatusInternalServerError, "Internal database error")
		return
	default:
		// pass
	}

	logger.Debug("Redirect", zap.String("id", id), zap.String("location", targetURL))
	ctx.Redirect(http.StatusPermanentRedirect, targetURL)
}

func (s *Handler) addURL(ctx *gin.Context) {
	logger := s.logger(ctx)
	urlInput := ctx.PostForm("url")
	parsedURL, err := url.Parse(urlInput)
	switch {
	case parsedURL.Scheme == "":
		err = errors.New("scheme must not be empty")
	case parsedURL.Host == "":
		err = errors.New("host must not be empty")
	default:
		// pass
	}
	if err != nil {
		logger.Debug("failed to parse url", zap.String("url", urlInput), zap.Error(err))
		s.errorPage(ctx, http.StatusBadRequest, fmt.Sprintf("failed to parse url: %v", err))
		return
	}

	id, err := s.storage.PutURL(ctx, urlInput)
	if err != nil {
		logger.Warn("failed to store url", zap.String("url", urlInput), zap.Error(err))
		s.errorPage(ctx, http.StatusInternalServerError, "Internal database error")
		return
	}

	scheme := "http"
	if ctx.Request.TLS != nil {
		scheme = "https"
	}

	sourceURL := url.URL{}
	sourceURL.Scheme = scheme
	sourceURL.Host = ctx.Request.Host
	sourceURL.Path = path.Join("r", id)

	data := pageTemplateData{
		SourceURL: sourceURL.String(),
		TargetURL: urlInput,
	}
	err = pageTemplate.Execute(ctx.Writer, data)
	if err != nil {
		logger.Warn("failed to execute template", zap.Error(err))
		ctx.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	logger.Debug("OK")
}

func (s *Handler) errorPage(ctx *gin.Context, code int, errorText string) {
	data := pageTemplateData{
		Error: errorText,
	}
	err := pageTemplate.Execute(ctx.Writer, data)
	if err != nil {
		s.logger(ctx).Warn("failed to execute template", zap.Error(err))
		ctx.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	ctx.AbortWithStatus(code)
}

func RequestIDMiddleware(logger *zap.Logger) gin.HandlerFunc {
	return func(c *gin.Context) {
		id := uuid.New().String()
		c.Header("X-Request-ID", id)
		c.Set("logger", logger.With(zap.String("request-id", id)))
	}
}
