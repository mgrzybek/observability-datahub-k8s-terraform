# observability-datahub-k8s-terraform
Read logs and metrics from Kafka topics and send them to S3, split GPDR logs and tech logs

## How it works

![Workflow diagram](./diagrams/workflow.svg)

The *logs* topic contains json-based messages. Two key fields are used:
* `log_type` from the main message
* `_log_type` in the nested json-based data within `message`

If their value is *application*, then the nested json is extracted to the main message and the field is tested.

```json
{
    "log_type":"application",
    "message":"{\"_log_type\":\"audit\",\"message\":\"Hello World from app !\"}"
}
```

If their value is *audit*, then the message is routed to the *auditlogs* topic.

```json
{
    "log_type":"audit",
    "message":"Hello World from audit !"
}
```
## How to use it

Each pod is a terraform-based module:

* [logs-splitter-logstash](https://github.com/mgrzybek/terraform-module-k8s-logstash-logs-splitter)
* [k8s-bucket-claim](https://github.com/mgrzybek/terraform-module-k8s-bucket-claim)
* logs-to-s3: *in progress*

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->