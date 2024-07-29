package utils

import (
	"context"

	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/propagation"
	"go.opentelemetry.io/otel/trace"
)

// 获取trace信息，用于发送给远程函数或不同进程的函数
func OtelPropagationInject(ctx context.Context) map[string]string {
	carrier := propagation.MapCarrier{}
	otel.GetTextMapPropagator().Inject(ctx, carrier)
	return carrier
}

// 根据接收的trace信息，生成新的context
// 注意调用方需要在调用函数后，执行defer span.End()
func OtelPropagationExtract(ctx context.Context, carrier map[string]string, spanName string) (context.Context, trace.Span) {
	tracer := otel.GetTracerProvider().Tracer(consts.ProjectName)
	newCtx := otel.GetTextMapPropagator().Extract(ctx, propagation.MapCarrier(carrier))
	spanCtx, span := tracer.Start(newCtx, spanName)
	return spanCtx, span
}
