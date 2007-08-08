package de.popforge.audio.processor.fl909.tone
{
	import de.popforge.parameter.MappingNumberLinear;
	import de.popforge.parameter.Parameter;
	
	public class ToneSnaredrum
	{
		public const tune: Parameter = new Parameter( new MappingNumberLinear( 0, 1 ), .75 );
		public const level: Parameter = new Parameter( new MappingNumberLinear( 0, 1 ), .75 );
		public const tone: Parameter = new Parameter( new MappingNumberLinear( 0, 1 ), .75 );
		public const snappy: Parameter = new Parameter( new MappingNumberLinear( 0, 1 ), .75 );
	}
}