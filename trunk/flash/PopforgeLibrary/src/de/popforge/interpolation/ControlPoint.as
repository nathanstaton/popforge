package de.popforge.interpolation
{
	import flash.net.registerClassAlias;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class ControlPoint implements IExternalizable
	{
		{
			registerClassAlias( 'ControlPoint', ControlPoint );
		}
		
		protected var _x: Number;
		protected var _y: Number;
		
		protected var defaultX: Number;
		protected var defaultY: Number;
		
		protected var changedCallbacks: Array;
		
		public function ControlPoint( x: Number = 0, y: Number = 0 )
		{
			changedCallbacks = new Array;
			
			_x = defaultX = x;
			_y = defaultY = y;
		}
		
		public function writeExternal( output: IDataOutput ): void
		{
			output.writeObject( defaultX );
			output.writeObject( defaultY );

			output.writeObject( _x );
			output.writeObject( _y );
		}
		
		public function readExternal( input: IDataInput ): void
		{
			var oldX: Number = _x;
			var oldY: Number = _y;
			
			defaultX = input.readObject();
			defaultY = input.readObject();
			
			_x = input.readObject();
			_y = input.readObject();
			
			valueChanged( oldX, oldY );
		}
		
		public function reset(): void
		{
			var oldX: Number = _x;
			var oldY: Number = _y;
			
			_x = defaultX;
			_y = defaultX;
			
			valueChanged( oldX, oldY );
		}
		
		public function set x( value: Number ): void
		{
			var oldX: Number = _x;
			
			_x = value;
			
			valueChanged( oldX, _y );
		}
		
		public function get x(): Number
		{
			return _x;
		}
		
		public function set y( value: Number ): void
		{
			var oldY: Number = _y;
			
			_y = value;
			
			valueChanged( _x, oldY );
		}
		
		public function get y(): Number
		{
			return _y;
		}
		
		public function addChangedCallbacks( callback: Function ): void
		{
			changedCallbacks.push( callback );
		}

		public function removeChangedCallbacks( callback: Function ): void
		{
			var index: int = changedCallbacks.indexOf( callback );
			
			if( index > -1 )
				changedCallbacks.splice( index, 1 );
		}
		
		private function valueChanged( oldX: Number, oldY: Number ): void
		{
			if( oldX == _x && oldY == _y )
				return;
			
			try
			{
				for each( var callback: Function in changedCallbacks )
					callback( this, oldX, oldY, _x, _y );
			}
			catch( e: ArgumentError )
			{
				throw new ArgumentError( 'Make sure callbacks have the following signature: (point: ControlPoint, oldX: Number, oldY: Number, x: Number, y: Number)' );
			}
		}
		
		public function toString(): String
		{
			return '[ControlPoint x: ' + _x.toString() + ', y: ' + _y.toString() + ']';
		}
	}
}