package feathers.core
{
   import starling.events.EventDispatcher;
   
   [Event(name="change",type="starling.events.Event")]
   public class TokenList extends EventDispatcher
   {
       
      
      protected var names:Vector.<String>;
      
      public function TokenList()
      {
         names = new Vector.<String>(0);
         super();
      }
      
      public function get value() : String
      {
         return names.join(" ");
      }
      
      public function set value(param1:String) : void
      {
         if(this.value == param1)
         {
            return;
         }
         this.names.length = 0;
         this.names = Vector.<String>(param1.split(" "));
         this.dispatchEventWith("change");
      }
      
      public function get length() : int
      {
         return this.names.length;
      }
      
      public function item(param1:int) : String
      {
         if(param1 < 0 || param1 >= this.names.length)
         {
            return null;
         }
         return this.names[param1];
      }
      
      public function add(param1:String) : void
      {
         var _loc2_:int = this.names.indexOf(param1);
         if(_loc2_ >= 0)
         {
            return;
         }
         this.names[this.names.length] = param1;
         this.dispatchEventWith("change");
      }
      
      public function remove(param1:String) : void
      {
         var _loc2_:int = this.names.indexOf(param1);
         this.removeAt(_loc2_);
      }
      
      public function toggle(param1:String) : void
      {
         var _loc2_:int = this.names.indexOf(param1);
         if(_loc2_ < 0)
         {
            this.names[this.names.length] = param1;
            this.dispatchEventWith("change");
         }
         else
         {
            this.removeAt(_loc2_);
         }
      }
      
      public function contains(param1:String) : Boolean
      {
         return this.names.indexOf(param1) >= 0;
      }
      
      protected function removeAt(param1:int) : void
      {
         if(param1 < 0)
         {
            return;
         }
         if(param1 == 0)
         {
            this.names.shift();
            this.dispatchEventWith("change");
            return;
         }
         var _loc2_:int = this.names.length - 1;
         if(param1 == _loc2_)
         {
            this.names.pop();
            this.dispatchEventWith("change");
            return;
         }
         this.names.splice(param1,1);
         this.dispatchEventWith("change");
      }
   }
}
