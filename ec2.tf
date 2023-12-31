#ARQUIVO UTILIZADO PARA A CRIAÇÃO DA INSTÂNCIA EC2
#NESSE TRECHO É FEITA A DEFINIÇÃO DE UMA CHAVE SSH VINCULADA A MINHA INSTÂNCIA
resource "aws_key_pair" "sshkey" {
  key_name   = "devops"
  public_key = file("./devops.pub")
}

#ESSE BLOCO É RESPONSÁVEL PELA CRIAÇÃO DA INSTÂNCIA
resource "aws_instance" "server" {
  ami                         = var.ami           //Aqui eu chamo a AMI que vai ser utilizada para a minha instância, foi escolhida uma AMI Ubunti 20.04
  instance_type               = var.instance_type //Foi escolhida uma instância do tipo t2.micro
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = aws_key_pair.sshkey.key_name
  user_data                   = file("./install_file.sh") //Nesse trecho de código eu chamo o arquivo que contem os comandos de instalação do docker dentro da minha instância

  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = "Terraform"
    repo        = var.repo
  }
}