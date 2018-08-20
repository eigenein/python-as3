package game.screen
{
   import org.osflash.signals.Signal;
   
   public class GameScreenSize
   {
       
      
      private var _width:Number;
      
      private var _height:Number;
      
      public const signal_resize:Signal = new Signal(Number,Number);
      
      public function GameScreenSize()
      {
         super();
      }
      
      public function get width() : Number
      {
         return _width;
      }
      
      public function get height() : Number
      {
         return _height;
      }
      
      public function initialize(param1:Number, param2:Number) : void
      {
         this._width = param1;
         this._height = param2;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         if(_width != param1 || _height != param2)
         {
            this._width = param1;
            this._height = param2;
            signal_resize.dispatch(_width,_height);
         }
      }
      
      public function onValue(param1:Function) : void
      {
         signal_resize.add(param1);
      }
   }
}
