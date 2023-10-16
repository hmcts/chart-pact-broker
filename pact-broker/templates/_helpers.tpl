---
{{/*
All the common lables needed for the lables sections of the definitions.
*/}}
{{- define "labels" }}
app.kubernetes.io/name: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name -}}
{{- if .Values.useWorkloadIdentity }}
azure.workload.identity/use: "true"
{{else }}
aadpodidbinding: {{ .Values.aadIdentityName }}
{{- end }}
{{- end -}}

{{- define "pact.vault" }}
  {{- if eq .Values.subscriptionId "bf308a5c-0624-4334-8ff8-8dca9fd43783"}}
  {{- "infra-vault-sandbox" -}}
  {{- else }}
  {{- "infra-vault-prod" -}}
  {{- end }}
{{- end }}
