# landfilesRclient

Basic functions to access [Landfiles](https://landfiles.com/)API from R. This R package was developped as part of the OPERA project 2021-2023 (France), with the support of the French Ministry of Agriculture and Food, and the financial contribution of the special allocation account for agricultural and rural development (CASDAR). The responsability of the French Ministry of Agriculture and Food cannot be engaged.

## Installation

To install the latest version of landfilesRclient

```         
library(remotes)
install_github("landfiles-opensource/Rclient")
```

## Example of use

```         
library(landfilesRclient)

## to get a token from the Landfiles API
## ask to Landfiles to have a username and a password for the API
token <- landfilesRclient::getToken(username = "********",
                           password = "**********")
# get a data.frame with all the groups accessible according to the rights of your account
groups <- getGroups(token=token)

# get a data.frame with all farms from a specific group
farms <- getFarms(group = groups$id[1],
                  token = token)

# get a data.frame with all plots from a specific group
plots <- getPlots(group = groups$id[1],
        token = token)


## create a map with plots of from the group
library(ggplot2)
map <- map_data("france")
ggplot(map,aes(long,lat,group=group)) +
  geom_polygon(fill="white",color="grey") +
  geom_jitter(data=plots,aes(x=longitude,y=latitude,group=NULL),size=3,width = 0.2,height = 0.2)
```

## Contribution

You can contribute to this projetc project by creating a pull request, or use issues to track bugs or suggest ideas in a repository.
