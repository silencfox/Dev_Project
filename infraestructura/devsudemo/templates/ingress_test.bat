{{- if .Values.ingress.enabled -}}
{{- $root := . }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .Release.Name }}-ingress
  labels:
    {{- include "devsudemo.labels" . | nindent 4 }}
  annotations:
    {{- with .Values.ingress.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
    {{- if eq .Values.environment "prod" }}
    cert-manager.io/cluster-issuer: {{ .Release.Name }}-letsencrypt
    {{- else }}
    cert-manager.io/issuer: {{ .Release.Name }}-selfsigned-issuer
    {{- end }}
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "5"
spec:
  {{- with .Values.ingress.className }}
  ingressClassName: {{ . }}
  {{- end }}
  {{- if .Values.ingress.tls }}
  tls:
    {{- range .Values.ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ $root.Release.Name }}-ingress-tls-secret
    {{- end }}
  {{- end }}
  rules:
    {{- range $i, $host := .Values.ingress.hosts }}
      http:
        paths:
          {{- range $j, $path := $host.paths }}
          - path: {{ $path.path }}
            pathType: {{ $path.pathType }}
            backend:
              service:
                name: {{ printf "%s-svc%d" $root.Release.Name (add $i 1) }}
                port:
                  number: {{ $root.Values.service.port }}
          {{- end }}
    {{- end }}
{{- end }}
