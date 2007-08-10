package de.popforge.audio.processor.fl909.voices
{
	import de.popforge.audio.output.Sample;
	import de.popforge.audio.processor.fl909.tone.ToneBase;
	
	public final class VoiceRimshot extends Voice
	{
		static private const snd: Array = Rom.getAmplitudesByName( '909.rim.raw' );
		
		private var tone: ToneBase;
		
		public function VoiceRimshot( start: int, volume: Number, tone: ToneBase )
		{
			super( start, volume );
			
			this.tone = tone;
			
			maxLength = length = snd.length;
		}
		
		public override function processAudioAdd( samples: Array ): Boolean
		{
			var n: int = samples.length;
			
			var sample: Sample;
			var amplitude: Number;
			
			var level: Number = tone.level.getValue() * volume;
			
			for( var i: int = start ; i < n ; i++ )
			{
				sample = samples[i];

				amplitude = snd[ position ] * level;

				//-- ADD AMPLITUDE (MONO)
				sample.left += amplitude;
				sample.right += amplitude;
				
				if( ++position >= length )
					return true;
			}

			start = 0;
			
			return false;
		}
	}
}