using Axl
@axlview polar((x,y,z)->cos(x*y*z+1.0), 200, field=DistField())