# Habitat Plan for NopCommerce

**Demo instructions can be found here:** [Demo Steps](https://github.com/devopslifter/nopcommerce/tree/master/terraform/aws).


nopCommerce is the best open-source e-commerce shopping cart. nopCommerce is available for free. Today it's the best and most popular ASP.NET ecommerce software. It has been downloaded more than 1.8 million times!

nopCommerce is a fully customizable shopping cart. It's stable and highly usable. nopCommerce is an open source ecommerce solution that is **ASP.NET Core** based with a MS SQL 2008 (or higher) backend database. Our easy-to-use shopping cart solution is uniquely suited for merchants that have outgrown existing systems, and may be hosted with your current web host or our hosting partners. It has everything you need to get started in selling physical and digital goods over the internet.

![nopCommerce demo](https://www.nopcommerce.com/images/features/responsive_devices_codeplex.jpg)


## Maintainers

Tom Finch tfinch@chef.io

## Type of Package

This is a Habitat service package

## Usage

This package is used to run the NopCommerce web application, to customise your MS SQL Server instance it is recommended to add a `post_run` hook to your sqlserver package to customise any database changes, create users and add any necessary privileges you require.

## Bindings

This package binds to Microsoft SQL Server 2008 or higher and contains all the necesary `.sql` to create a starter database to demo with.
 
Example bind

`hab svc load devopslifter/nop-commerce --bind database:sqlserver.default`

## Terraform

Included in the repo is terraform code for launching the application in AWS
