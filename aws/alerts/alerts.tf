resource "aws_cloudwatch_metric_alarm" "status-check-failed" {
  alarm_name          = "Status-Check-Failed"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  =  "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              =  "60"
  statistic           = "Maximum"
  threshold           = "1"
  treat_missing_data  = "missing"
  datapoints_to_alarm = "1"
  dimensions          = {
    InstanceId = "i-79182739871"
  }
  alarm_description   = "This metric monitor ec2 instance status check"
  alarm_actions       = [
    "arn:aws:swf:eu-west-1:111111111111:action/actions/AWS_EC2.InstanceId.Reboot/1.0" //The actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN).
  ]
}