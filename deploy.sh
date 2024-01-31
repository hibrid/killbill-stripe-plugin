#!/bin/bash

# Copyright 2020-2020 Equinix, Inc
# Copyright 2014-2020 The Billing Project, LLC
#
# The Billing Project licenses this file to you under the Apache License, version 2.0
# (the "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at:
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.


KB_CONTAINER_NAME=killbill-killbill-1
PLUGIN_VERSION=8.0.1-SNAPSHOT

mvn clean install -DskipTests

docker cp ./target/stripe-plugin-$PLUGIN_VERSION.jar $KB_CONTAINER_NAME:/

docker exec -it $KB_CONTAINER_NAME kpm install_java_plugin stripe --from-source-file=/stripe-plugin-$PLUGIN_VERSION.jar --destination=/var/lib/killbill/bundles

docker container restart $KB_CONTAINER_NAME
