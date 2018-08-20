package game.model.user.specialoffer
{
   import avmplus.getQualifiedClassName;
   import engine.core.animation.ZSortedSprite;
   import engine.core.clipgui.IGuiClip;
   import flash.utils.Dictionary;
   import game.view.gui.components.ClipLayout;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class SpecialOfferDisplayObjectHook
   {
       
      
      private var signal:Signal;
      
      private var objects:Dictionary;
      
      public function SpecialOfferDisplayObjectHook(param1:*)
      {
         objects = new Dictionary();
         super();
         signal = new Signal(param1);
      }
      
      function add(param1:Function) : void
      {
         signal.add(param1);
         var _loc4_:int = 0;
         var _loc3_:* = objects;
         for each(var _loc2_ in objects)
         {
            param1(_loc2_);
         }
      }
      
      function remove(param1:Function) : void
      {
         signal.remove(param1);
      }
      
      public function register(param1:Object) : void
      {
         var _loc2_:* = undefined;
         signal.dispatch(param1);
         if(param1 is ISpecialOfferDisplayObjectProvider)
         {
            _loc2_ = (param1 as ISpecialOfferDisplayObjectProvider).graphics;
         }
         else
         {
            _loc2_ = param1;
         }
         var _loc3_:DisplayObject = null;
         if(_loc2_ is ClipLayout)
         {
            _loc3_ = _loc2_ as ClipLayout;
         }
         else if(_loc2_ is IGuiClip)
         {
            _loc3_ = (_loc2_ as IGuiClip).graphics as ZSortedSprite;
         }
         else
         {
            _loc3_ = _loc2_ as ZSortedSprite;
         }
         if(_loc3_ != null)
         {
            objects[_loc3_] = param1;
            _loc3_.addEventListener("disposed",handler_disposed);
         }
         else
         {
            trace(getQualifiedClassName(this),"registered object can\'t dispatch DISPOSED event");
         }
      }
      
      protected function unregister(param1:Object) : void
      {
      }
      
      private function handler_disposed(param1:Event) : void
      {
         unregister(param1.target as DisplayObject);
      }
   }
}
