# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

OUTPUT_DIR=bin
OTEL_VERSION=0.57.0

IMAGE_NAME=otelcol-custom
IMAGE_VERSION=latest

.PHONY: setup
setup:
	curl -L -o ${OUTPUT_DIR}/ocb --create-dirs https://github.com/open-telemetry/opentelemetry-collector/releases/download/v${OTEL_VERSION}/ocb_${OTEL_VERSION}_linux_amd64
	chmod +x ${OUTPUT_DIR}/ocb


.PHONY: build
build: setup
	bin/ocb --config=builder-config.yaml --name=otelcol-custom --output-path=bin/.

.PHONY: docker-build
docker-build:
	docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} .
