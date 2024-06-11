dashboard "aws_ec2_ami_dashboard" {
  title = "AWS EC2 AMI Details Dashboard"

  container {
    table {
      title = "AMI Details"
      sql = <<EOQ
        select
          instance_id,
          instance_state,
          launch_time,
          state_transition_time
        from
          aws_ec2_instance
        where
          instance_state = 'stopped'
          and state_transition_time <= (current_date - interval '30' day);
      EOQ
    }
  }
}
