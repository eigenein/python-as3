package game.view.gui.components.list
{
   import avmplus.getQualifiedClassName;
   import feathers.controls.List;
   import flash.utils.Dictionary;
   import starling.events.Event;
   
   public class ItemList extends List
   {
       
      
      private var listeners:Dictionary;
      
      public function ItemList()
      {
         listeners = new Dictionary();
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var _loc3_:int = 0;
         var _loc2_:* = listeners;
         for(var _loc1_ in listeners)
         {
            delete listeners[_loc1_];
         }
      }
      
      public function addDataListener(param1:String, param2:Function) : void
      {
         if(listeners[param1])
         {
            throw new ArgumentError("Listener for eventType `" + param1 + "` already set in " + getQualifiedClassName(this));
         }
         addEventListener(param1,itemDataHandler);
         listeners[param1] = param2;
      }
      
      protected function itemDataHandler(param1:Event) : void
      {
         if(listeners[param1.type])
         {
            listeners[param1.type](param1.data);
         }
      }
   }
}
