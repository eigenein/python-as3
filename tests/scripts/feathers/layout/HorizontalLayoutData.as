package feathers.layout
{
   import starling.events.EventDispatcher;
   
   [Event(name="change",type="starling.events.Event")]
   public class HorizontalLayoutData extends EventDispatcher implements ILayoutData
   {
       
      
      protected var _percentWidth:Number;
      
      protected var _percentHeight:Number;
      
      public function HorizontalLayoutData(param1:Number = NaN, param2:Number = NaN)
      {
         super();
         this._percentWidth = param1;
         this._percentHeight = param2;
      }
      
      public function get percentWidth() : Number
      {
         return this._percentWidth;
      }
      
      public function set percentWidth(param1:Number) : void
      {
         if(this._percentWidth == param1)
         {
            return;
         }
         this._percentWidth = param1;
         this.dispatchEventWith("change");
      }
      
      public function get percentHeight() : Number
      {
         return this._percentHeight;
      }
      
      public function set percentHeight(param1:Number) : void
      {
         if(this._percentHeight == param1)
         {
            return;
         }
         this._percentHeight = param1;
         this.dispatchEventWith("change");
      }
   }
}
