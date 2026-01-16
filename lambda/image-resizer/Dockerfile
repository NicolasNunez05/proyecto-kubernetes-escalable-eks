# Usamos la imagen base de AWS para Python 3.11
FROM public.ecr.aws/lambda/python:3.11

# Copiamos requirements
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Instalamos dependencias en la carpeta del sistema
RUN pip install -r requirements.txt

# Copiamos el código de la función
COPY lambda_function.py ${LAMBDA_TASK_ROOT}

# El comando CMD se define en el Terraform o aquí
CMD [ "lambda_function.lambda_handler" ]