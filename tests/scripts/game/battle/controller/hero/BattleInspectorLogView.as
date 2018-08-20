package game.battle.controller.hero
{
   import battle.log.BattleLogEvent;
   import battle.log.BattleLogEventHeroDamage;
   import battle.log.BattleLogEventHeroMove;
   import feathers.data.ListCollection;
   import flash.desktop.Clipboard;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class BattleInspectorLogView
   {
       
      
      private var container:DisplayObjectContainer;
      
      private var clip:BattleInspectorLogViewClip;
      
      private var _inited:Boolean;
      
      private var _visible:Boolean = true;
      
      private var currentLog:Vector.<BattleLogEvent>;
      
      public function BattleInspectorLogView(param1:DisplayObjectContainer)
      {
         clip = new BattleInspectorLogViewClip();
         currentLog = new Vector.<BattleLogEvent>();
         super();
         this.container = param1;
         param1.addEventListener("removed",handler_removed);
         AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.dialog_test_battle,handler_asset);
      }
      
      protected function logToString(param1:Vector.<BattleLogEvent>) : String
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc6_:int = param1.length;
         var _loc2_:String = "";
         var _loc5_:Number = NaN;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc3_ = param1[_loc4_];
            if(_loc5_ != _loc3_.time)
            {
               _loc5_ = _loc3_.time;
               _loc2_ = _loc2_ + (_loc5_ + ":\n");
            }
            _loc2_ = _loc2_ + ("   " + _loc3_.toString(BattleInspectorLog.instance.namer) + "\n");
            _loc4_++;
         }
         return _loc2_;
      }
      
      protected function logToStringVector(param1:Vector.<BattleLogEvent>) : Vector.<StringValueObject>
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc6_:int = param1.length;
         var _loc3_:Vector.<StringValueObject> = new Vector.<StringValueObject>();
         var _loc5_:Number = NaN;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc2_ = param1[_loc4_];
            if(_loc5_ != _loc2_.time)
            {
               _loc5_ = _loc2_.time;
               _loc3_.push(new StringValueObject(_loc5_ + ":"));
            }
            _loc3_.push(new StringValueObject("   " + _loc2_.toString(BattleInspectorLog.instance.namerColored)));
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function handler_showLog(param1:Boolean) : void
      {
         if(param1)
         {
            container.addChild(clip.graphics);
         }
         else
         {
            container.removeChild(clip.graphics);
         }
      }
      
      private function handler_removed(param1:Event) : void
      {
         if(param1.target != param1.currentTarget)
         {
            return;
         }
         if(BattleInspectorLog.instance)
         {
            BattleInspectorLog.instance.signal_log.remove(handler_log);
         }
      }
      
      private function handler_log(param1:Vector.<BattleLogEvent>) : void
      {
         var _loc2_:* = clip.scrollContainer.verticalScrollPosition == clip.scrollContainer.maxVerticalScrollPosition;
         syncLogs(param1);
         if(_loc2_)
         {
            clip.scrollContainer.validate();
            clip.scrollContainer.verticalScrollPosition = clip.scrollContainer.maxVerticalScrollPosition;
         }
      }
      
      private function handler_asset(param1:RsxGuiAsset) : void
      {
         AssetStorage.rsx.dialog_test_battle.initGuiClip(clip,"BattleInspectorLogView");
         clip.scrollContainer.dataProvider = new ListCollection();
         clip.button_hide.initialize("Скрыть",handler_hide);
         clip.button_copy.label = "Скопировать";
         clip.button_copy.createNativeClickHandler().add(handler_copy);
         _inited = true;
         if(BattleInspectorLog.instance)
         {
            BattleInspectorLog.instance.showLog.onValue(handler_showLog);
            BattleInspectorLog.instance.signal_log.add(handler_log);
         }
      }
      
      private function syncLogs(param1:Vector.<BattleLogEvent>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:Number = currentLog.length > 0?currentLog[currentLog.length - 1].time:NaN;
         _loc3_ = currentLog.length;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_];
            currentLog.push(_loc2_);
            if(_loc4_ != _loc2_.time)
            {
               _loc4_ = _loc2_.time;
               clip.scrollContainer.dataProvider.addItem(new StringValueObject(_loc4_ + ":"));
            }
            clip.scrollContainer.dataProvider.addItem(createLogVo(_loc2_));
            _loc3_++;
         }
      }
      
      private function createLogVo(param1:BattleLogEvent) : StringValueObject
      {
         var _loc2_:StringValueObject = new StringValueObject(BattleInspectorLog.DEFAULT_COLOR + "   " + param1.toString(BattleInspectorLog.instance.namerColored));
         if(param1 is BattleLogEventHeroDamage)
         {
            _loc2_.alpha = 1;
         }
         else if(param1 is BattleLogEventHeroMove)
         {
            _loc2_.alpha = 0.4;
         }
         else
         {
            _loc2_.alpha = 0.7;
         }
         return _loc2_;
      }
      
      private function handler_hide() : void
      {
         BattleInspectorLog.instance.showLog.value = false;
      }
      
      private function handler_copy() : void
      {
         var _loc1_:String = logToString(currentLog);
         Clipboard.generalClipboard.setData("air:text",_loc1_);
      }
   }
}

class StringValueObject
{
    
   
   private var _value:String;
   
   public var alpha:Number = 1;
   
   function StringValueObject(param1:String)
   {
      super();
      _value = param1;
   }
   
   public function toString() : String
   {
      return _value;
   }
}
