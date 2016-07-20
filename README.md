# docker-argo-erddap

5 minutes from now your [Argo floats](http://www.argo.ucsd.edu/) will be in [NOAA ERDDAP](https://coastwatch.pfeg.noaa.gov/erddap/).

    git clone https://github.com/IrishMarineInstitute/docker-argo-erddap
    cd docker-argo-erddap
    docker build -t argo-erddap .

Now you're ready to go!

    docker run -d -p 8080:8080 --name=myargos argo-erddap

or

    docker run -d -p 80:8080 --name=myargos argo-erddap


You should now [have a running ERDDAP](http://localhost:8080/erddap/index.html) , but without much data

## Adding a float

To add a new float, call add_float, giving the platform number.

    docker exec -i -t myargos add_float 6901921

As the [argoCollector](https://github.com/IrishMarineInstitute/argoCollector) eventually politely downloads the float's dataset files, you will see the fetched urls appear on the console. The new platform_number will be visible in ERDDAP.

## Removing a float

To remove a float, call del_float, giving the platform number.

    docker exec -i -t myargos del_float 6901921

The removed platform_number will be gone from ERDDAP.

## Updating floats

To update ERDDAP with the latest float data, call update_floats

    docker exec -i -t myargos update_floats

As the [argoCollector](https://github.com/IrishMarineInstitute/argoCollector) politely checks for and downloads any new dataset files, you will see the fetched urls appear on the console. The new platform_number will be visible in ERDDAP.

A job like this could run hourly or daily in cron, checking for updates to your floats:

    0 * * * * docker exec -i -t myargos update_floats


## Exposing to the public

To expose your ERDDAP on a public url, use the baseUrl function. Here we see the baseUrl being set on an insttance which exposes  ERDDAP on the default http port.

    docker exec -i -t myargos baseUrl http://idockan02.northeurope.cloudapp.azure.com
    docker stop myargos
    docker start myargos

Remember to restart the docker container after updating the baseUrl.
