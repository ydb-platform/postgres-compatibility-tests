package main

import (
	_ "embed"
	ginzap "github.com/gin-contrib/zap"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"html/template"
	"net/http"
	"time"
)

//go:embed page_template.html
var pageTemplateText string

var pageTemplate = template.Must(template.New("page").Parse(pageTemplateText))

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

	return handler
}

func (s *Handler) ServeHTTP(writer http.ResponseWriter, request *http.Request) {
	s.gin.ServeHTTP(writer, request)
}

func (s *Handler) mainPage(c *gin.Context) {
	logger := s.logger(c)
	err := pageTemplate.Execute(c.Writer, nil)
	if err != nil {
		logger.Warn("failed to parse template", zap.Error(err))
		http.Error(c.Writer, err.Error(), http.StatusInternalServerError)
	}
	logger.Debug("OK")
}

func (s *Handler) logger(c *gin.Context) *zap.Logger {
	val, ok := c.Get("logger")
	if ok {
		return val.(*zap.Logger)
	}
	return zap.NewNop()
}

func RequestIDMiddleware(logger *zap.Logger) gin.HandlerFunc {
	return func(c *gin.Context) {
		id := uuid.New().String()
		c.Header("X-Request-ID", id)
		c.Set("logger", logger.With(zap.String("request-id", id)))
	}
}
