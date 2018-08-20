package game.view.gui.components
{
   import idv.cjcat.signals.Signal;
   
   public class GuiSubscriber
   {
       
      
      private var entries:Array;
      
      public function GuiSubscriber()
      {
         entries = [];
         super();
      }
      
      public function dispose() : void
      {
         clear();
      }
      
      public function add(param1:Signal, param2:Function) : void
      {
         entries.push(param1,param2);
         param1.add(param2);
      }
      
      public function clear() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc2_:int = entries.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = entries[_loc3_];
            _loc1_ = entries[_loc3_ + 1];
            _loc4_.remove(_loc1_);
            _loc3_ = _loc3_ + 2;
         }
         entries.length = 0;
      }
   }
}
