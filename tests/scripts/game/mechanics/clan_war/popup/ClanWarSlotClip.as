package game.mechanics.clan_war.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.clan_war.mediator.ClanWarSlotState;
   import game.mechanics.clan_war.model.ClanWarSlotBase;
   import game.view.gui.components.ClipLayout;
   
   public class ClanWarSlotClip extends GuiClipNestedContainer
   {
       
      
      public var shadow:ClipSprite;
      
      public var mark_filled_me:ClipSprite;
      
      public var mark_defeated:ClipSprite;
      
      public var mark_filled:ClipSprite;
      
      public var mark_frame:ClipSprite;
      
      public var mark_flame:GuiAnimation;
      
      public var layout:ClipLayout;
      
      private var _data:ClanWarSlotBase;
      
      public function ClanWarSlotClip()
      {
         shadow = new ClipSprite();
         mark_filled_me = new ClipSprite();
         mark_defeated = new ClipSprite();
         mark_filled = new ClipSprite();
         mark_frame = new ClipSprite();
         mark_flame = new GuiAnimation();
         layout = ClipLayout.none(shadow,mark_flame,mark_frame,mark_filled,mark_defeated,mark_defeated,mark_filled_me);
         super();
      }
      
      public function dispose() : void
      {
         data = null;
      }
      
      public function get data() : ClanWarSlotBase
      {
         return _data;
      }
      
      public function set data(param1:ClanWarSlotBase) : void
      {
         if(data)
         {
            data.property_clanWarSlotState.signal_update.remove(handler_updateSlotState);
         }
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         if(data)
         {
            data.property_clanWarSlotState.signal_update.add(handler_updateSlotState);
            handler_updateSlotState(param1.slotState);
         }
      }
      
      public function setState(param1:ClanWarSlotState) : void
      {
         handler_updateSlotState(param1);
      }
      
      private function handler_updateSlotState(param1:ClanWarSlotState) : void
      {
         var _loc2_:* = param1 == ClanWarSlotState.DEFEATED;
         mark_defeated.graphics.visible = param1 == ClanWarSlotState.DEFEATED;
         mark_frame.graphics.visible = param1 == ClanWarSlotState.EMPTY;
         mark_filled.graphics.visible = param1 == ClanWarSlotState.READY || param1 == ClanWarSlotState.IN_BATTLE;
         mark_flame.graphics.visible = param1 == ClanWarSlotState.IN_BATTLE;
         mark_filled_me.graphics.visible = false;
         if(mark_flame.graphics.visible)
         {
            mark_flame.play();
         }
         else
         {
            mark_flame.stop();
         }
      }
   }
}
