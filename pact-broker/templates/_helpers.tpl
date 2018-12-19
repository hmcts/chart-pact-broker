{{/*
All the common lables needed for the lables sections of the definitions.
*/}}
{{- define "labels" }}
app.kubernetes.io/name: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name -}}
{{- end -}}
