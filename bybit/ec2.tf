data "aws_ami" "linux2" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "architecture"
        values = ["x86_64"]
    }

    filter {
        name = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name = "block-device-mapping.volume-type"
        values = ["gp2"]
    }

    filter {
        name = "state"
        values = ["available"]
    }
}

resource "aws_instance" "bybit" {
    ami = data.aws_ami.linux2.image_id
    vpc_security_group_ids = [aws_security_group.bybit.id]
    subnet_id = aws_subnet.bybit.id
    key_name = aws_key_pair.bot.id
    instance_type = "t2.micro"

    root_block_device {
        volume_size = 12
        volume_type = "gp3"
        delete_on_termination = true
        tags = {
            Name = "bybit"
        }
    }

    tags = {
      Name = "bybit"
    }


}

resource "aws_eip" "bybit" {
  instance = aws_instance.bybit.id
  vpc = true
}

resource "aws_key_pair" "bot" {
  key_name = "bot"
  public_key = file("../.ssh/bot.pub")
}