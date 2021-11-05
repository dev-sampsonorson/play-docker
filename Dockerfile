# Every instruction in this docker file is
# considered its own step or layer

# to keep thing efficient docker will cache
# layers if nothing has changed

# Normally if working on a node project,
# you get your source code then install dependencies
# In docker, you want to install your dependencies first
# so that they can be cached. We don't want to 
# reinstall all our node modules anytime we
# change our app source code

# Set the base image
# Layer 1
FROM node:14

# Add app source code to the image
# Layer 2
WORKDIR /app

# Layer 3
COPY package*.json ./

# open a terminal and run a command
# Shell form
# Layer 4
RUN npm install

# copy over our source code
# Layer 5
COPY . .

# use an environment variable to run our code
# Layer 6
ENV PORT=8080

# Layer 7
EXPOSE 8080

# There can only be one of this per docker file
# it tells the container how to run the actual application
# Exec form - unlike a regular command it doesn't startup
#             a shell session
# Layer 8
CMD ["npm", "start"]