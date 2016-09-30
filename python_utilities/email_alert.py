import smtplib
from email.mime.text import MIMEText
from clite import CLIte

def send_alert (recivers, sender, subject, msg):
        msg = MIMEText(msg)
        msg['Subject'] = subject
        msg["From"] = sender
        msg["To"] = recivers
        
        #send messege
        server = smtplib.SMTP('smtp.uaf.edu')
        server.sendmail(sender,recivers,msg.as_string())
        server.quit()


if __name__ == "__main__":
    cli = CLIte(['--to', '--from'])
    
    send_alert(cli['--to'], cli['--from'], 'test python alert', 'test message')
