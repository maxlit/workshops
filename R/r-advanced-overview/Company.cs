class Company
{
	private double HC;
	private double EBIT;
	
	public Company(double HC, double EBIT)
	{
		this.HC = HC;
		this.EBIT = EBIT;
	}

	public static operator +(Company A, Company B)
  	{
    		double HC = (A.HC + B.HC)*0.8;
    		double EBIT = (A.EBIT + B.EBIT)*1.2;
		return new Company(HC, EBIT)
	}
}

// a few calls:
// Company Microsoft = new Company(50, 95)
// Company LinkedIn = new Company(2, 5)
// Microsoft + LinkedIn