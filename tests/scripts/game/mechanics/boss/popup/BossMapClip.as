package game.mechanics.boss.popup
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiMarker;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import idv.cjcat.signals.Signal;
   
   public class BossMapClip extends GuiClipNestedContainer
   {
       
      
      public const entries:Vector.<BossMapEntryView> = new Vector.<BossMapEntryView>();
      
      public const signal_clickAttack:Signal = new Signal();
      
      public const signal_clickRaid:Signal = new Signal();
      
      public const signal_clickChestOpen:Signal = new Signal();
      
      private var bossMapPathAnimation:BossMapPathAnimation;
      
      public var boss:Vector.<GuiMarker>;
      
      public var chest:Vector.<GuiMarker>;
      
      public var chest_big:Vector.<GuiMarker>;
      
      public var ui:Vector.<GuiMarker>;
      
      public var chest_center:Vector.<GuiMarker>;
      
      public function BossMapClip()
      {
         super();
      }
      
      public function dispose() : void
      {
         signal_clickAttack.clear();
         signal_clickRaid.clear();
         signal_clickChestOpen.clear();
         if(bossMapPathAnimation)
         {
            bossMapPathAnimation.dispose();
         }
      }
      
      public function get entriesCount() : int
      {
         if(boss == null || chest == null || chest_big == null)
         {
            return 0;
         }
         return Math.min(boss.length,chest.length,chest_big.length);
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         super.setNode(param1);
         var _loc7_:int = entriesCount;
         entries.length = _loc7_;
         var _loc8_:Vector.<Point> = new Vector.<Point>();
         var _loc2_:* = 2147483647;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc5_ = chest[_loc4_];
            entries[_loc4_] = new BossMapEntryView(_loc5_,chest_big[_loc4_],boss[_loc4_],ui[_loc4_],chest_center[_loc4_]);
            entries[_loc4_].signal_clickAttack.add(handler_attack);
            entries[_loc4_].signal_clickRaid.add(handler_raid);
            entries[_loc4_].signal_clickChestOpen.add(handler_chestOpen);
            _loc8_.push(new Point(_loc5_.graphics.x,_loc5_.graphics.y));
            _loc6_ = _loc5_.graphics.parent.getChildIndex(_loc5_.graphics);
            if(_loc6_ < _loc2_)
            {
               _loc2_ = _loc6_;
            }
            _loc4_++;
         }
         if(_loc2_ < 2147483647)
         {
            _loc3_ = AssetStorage.rsx.dialog_boss.data.getClipByName("animation_waypoint");
            bossMapPathAnimation = new BossMapPathAnimation(_loc8_,_loc3_);
            container.addChildAt(bossMapPathAnimation.graphics,_loc2_);
         }
      }
      
      private function handler_attack() : void
      {
         signal_clickAttack.dispatch();
      }
      
      private function handler_raid() : void
      {
         signal_clickRaid.dispatch();
      }
      
      private function handler_chestOpen() : void
      {
         signal_clickChestOpen.dispatch();
      }
   }
}
