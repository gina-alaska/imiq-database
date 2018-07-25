"""
courrier
--------

A simple email function. Courrier: french for mail. 

Rawser Spicer
version: 1.0.0
Split from imiq-database python utilities: 2017-08-18
"""
import smtplib
from email.mime.text import MIMEText
from clite import CLIte

def courrier (recivers, sender, subject, msg, stmp_server = ''):
    """Sends an email from a python utility
    """
    msg = MIMEText(msg)
    msg['Subject'] = subject
    msg["From"] = sender
    msg["To"] = recivers
    
    #send messege
    server = smtplib.SMTP(stmp_server)
    server.sendmail(sender,recivers,msg.as_string())
    server.quit()


if __name__ == "__main__":
    cli = CLIte(['--to', '--from'])
    
    courrier(cli['--to'], cli['--from'], 'test python alert', 'test message')
