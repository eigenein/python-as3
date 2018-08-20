package game.view.gui.worldmap
{
   import feathers.controls.ScrollContainer;
   import feathers.data.ListCollection;
   import game.data.storage.pve.mission.MissionDescription;
   import game.mediator.gui.worldmap.WorldMapListValueObject;
   import game.view.gui.components.ClipButtonBase;
   import starling.events.Event;
   
   public class WorldMapViewScrollContainer extends ScrollContainer
   {
       
      
      private var _listCollection:ListCollection;
      
      private var _scrollDuration:Number = 1;
      
      private var _ignoreLayout:Boolean = true;
      
      public function WorldMapViewScrollContainer(param1:ListCollection)
      {
         super();
         this._listCollection = param1;
         param1.addEventListener("addItem",handler_itemAdded);
      }
      
      override public function dispose() : void
      {
         _listCollection.removeEventListener("addItem",handler_itemAdded);
         super.dispose();
      }
      
      public function scrollToWorld(param1:WorldMapListValueObject) : void
      {
         _scrollToWorld(param1,true);
      }
      
      public function jumpToWorld(param1:WorldMapListValueObject) : void
      {
         _scrollToWorld(param1,false);
      }
      
      override public function scrollToPosition(param1:Number, param2:Number, param3:Number = NaN) : void
      {
         if(param1 == 0)
         {
            _ignoreLayout = false;
         }
         super.scrollToPosition(param1,param2,param3);
      }
      
      public function getButtonByMission(param1:WorldMapListValueObject, param2:MissionDescription) : ClipButtonBase
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function draw() : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(isInvalid("pendingScroll"))
         {
            _ignoreLayout = false;
         }
         if(_ignoreLayout)
         {
            return;
         }
         var _loc3_:int = numChildren;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc2_ = getChildAt(_loc7_) as WorldMapViewRenderer;
            _loc6_ = horizontalScrollPosition;
            _loc8_ = _loc6_ + width;
            _loc4_ = _loc6_;
            _loc1_ = _loc2_.x;
            _loc5_ = _loc2_.x + _loc2_.width;
            if(_loc1_ >= _loc4_ && _loc1_ <= _loc8_ || _loc5_ >= _loc4_ && _loc5_ <= _loc8_)
            {
               if(_loc2_.map != null)
               {
                  _loc2_.show();
               }
            }
            else
            {
               _loc2_.hide();
            }
            _loc7_++;
         }
      }
      
      override protected function initialize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.initialize();
         verticalScrollPolicy = "off";
         interactionMode = "mouse";
         snapToPages = true;
         if(_listCollection.length)
         {
            _loc1_ = _listCollection.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               addRenderer(_listCollection.getItemAt(_loc2_) as WorldMapListValueObject,_loc2_);
               _loc2_++;
            }
         }
      }
      
      private function addRenderer(param1:WorldMapListValueObject, param2:int) : void
      {
         var _loc3_:WorldMapViewRenderer = new WorldMapViewRenderer();
         _loc3_.data = param1;
         addChild(_loc3_);
         _loc3_.x = (numChildren - 1) * _loc3_.width;
      }
      
      private function _scrollToWorld(param1:WorldMapListValueObject, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = numChildren;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = getChildAt(_loc5_) as WorldMapViewRenderer;
            if(_loc3_.map == param1)
            {
               scrollToPosition(_loc3_.x,0,!!param2?_scrollDuration:0);
               return;
            }
            _loc5_++;
         }
      }
      
      private function handler_itemAdded(param1:Event) : void
      {
         var _loc3_:int = param1.data as int;
         var _loc2_:WorldMapListValueObject = _listCollection.getItemAt(_loc3_) as WorldMapListValueObject;
         addRenderer(_loc2_,_loc3_);
      }
   }
}
