{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "velero.fullname" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "velero.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "velero.labels" -}}
helm.sh/chart: {{ include "velero.chart" . }}
{{ include "velero.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "velero.selectorLabels" -}}
app.kubernetes.io/name: {{ include "velero.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "velero.serviceAccountName" -}}
{{ include "velero.fullname" . }}
{{- end }}

{{/*
Create s3SecretName
*/}}
{{- define "velero.s3SecretName" -}}
{{- printf "%s-%s" .Chart.Name "s3" | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the backup storage location name
*/}}
{{- define "velero.backupStorageLocation.name" -}}
{{- with .Values.configuration.backupStorageLocation -}}
{{ default "default" .name }}
{{- end -}}
{{- end -}}

{{/*
Create the backup storage location provider
*/}}
{{- define "velero.backupStorageLocation.provider" -}}
{{- with .Values.configuration -}}
{{ default .provider .backupStorageLocation.provider }}
{{- end -}}
{{- end -}}