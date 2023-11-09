# ua-market-basket

This project aims for regular data collection of the prices of goods and services that constitute market basket in Ukraine.

Currently available dataset captures weekly prices and a bunch of other variables for the food products that constitute a \"food set\" of the consumer basket. As a whole, consumer basket in Ukraine consists of three parts: a food set, non-food items like clothes and devices, and basic services like transportation or electricity. In its turn, the cost of consumer basket is a base for calculation of the living (subsistence) minimum. The living minimum is a social standard in Ukraine; the state grants every citizen to have this sum of money at their disposal. As for Jan 1, 2023, for a person capable of working the official amount is 2684 UAH. The problem is that this sum is not enough for addressing the basic needs according to the norms of consumption which the state has itself declared . So, one of the possible usage of the presented data is to track the gap between official amount of living minimum and actual market cost of the consumer basket.

### Data sets

#### a. ua-foodset-prices.csv

There are 9 variables in the dataset, the start of observations is September 7, 2023.

**Variables**:

1.  date: date of data collection, date format is \"%y-%m-%d\".

2.  retailer: code of the retailer, \"atb\" is [www.atbmarket.com](http://www.atbmarket.com) [currently it is the only source of prices]

3.  web.cat.name: part of the actual URL describing the source category for data collection.

4.  prod.group: 47 product groups containing all the particular goods. These groups are defined by a resolution of the Cabinet of Minisers of Ukraine for working population (link to the doc\'s section: [[https://zakon.rada.gov.ua/laws/show/780-2016-%D0%BF#n16]{.underline}](https://zakon.rada.gov.ua/laws/show/780-2016-%D0%BF#n16)).

5.  desc: detailed descripiton of a good (in Ukrainian), incl. brand (if available), weight and other product details.

6.  price: retail price in UAH at the date of data collection, includes taxes.

7.  metric.un: metric units in g-grams/ kg-kilograms/ ml-milliliters/ l-liters/ pack (the last one stands exclusively for a pack of 10 eggs).

8.  metric.weight: weight in metric units, extracted from the desc.

9.  price.per.m.u: price of the good per kilogram / liter / pack.

#### b. ua-food-norms.csv

The minimal annual norms of food consumption are defined with resolution of the Cabinet of Ministers of Ukraine for working population: [[https://zakon.rada.gov.ua/laws/show/780-2016-%D0%BF#n16]{.underline}](https://zakon.rada.gov.ua/laws/show/780-2016-%D0%BF#n16)).

I have slightly changed the numbers: for the fermented dairy products the document states a person to have 60 liters per year of both kefir and baked milk (\"riazhanka\"). As my price data is at the level of a particular goods, in this example I have assigned 55 liters to kefir and 5 liters to baked milk. There are few similar examples.

**Variables:**

1.  prod.group: a product group for which a norm of consumption is defined. Rows here are identical to the rows of prod.group variable from the ua-foodset-prices.csv.

2.  food.norms: actual consumption norms for the subsistence level. Norms are either in liters/ kilograms depending on the product; eggs are in pieces, it is the only exception.
