package game.view.popup.clan.activitystats
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.toggle.ClipToggleButton;
   
   public class ClanReceiverGiftRenderer extends ListItemRenderer
   {
       
      
      private var clip:ClanReceiverGiftRendererClip;
      
      public function ClanReceiverGiftRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:ClanGiftStatsVO = data as ClanGiftStatsVO;
         if(_loc2_)
         {
            _loc2_.property_selected.signal_update.remove(handler_selectedUpdate);
            _loc2_.property_selectable.signal_update.remove(handler_selectableUpdate);
            _loc2_.property_giftsReceived.signal_update.remove(handler_giftCountUpdate);
         }
         .super.data = param1;
         _loc2_ = data as ClanGiftStatsVO;
         if(_loc2_)
         {
            _loc2_.property_selected.signal_update.add(handler_selectedUpdate);
            _loc2_.property_selectable.signal_update.add(handler_selectableUpdate);
            _loc2_.property_giftsReceived.signal_update.add(handler_giftCountUpdate);
         }
      }
      
      override protected function commitData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _loc1_ = null;
         super.commitData();
         var _loc2_:ClanGiftStatsVO = data as ClanGiftStatsVO;
         if(clip && _loc2_)
         {
            clip.tf_name.text = _loc2_.nickname;
            clip.line.graphics.visible = index > 0;
            clip.checkBox.graphics.visible = _loc2_.playerCanSend;
            clip.playback.gotoAndStop(int(!_loc2_.playerCanSend));
            clip.bg_player.graphics.visible = _loc2_.isPlayer;
            clip.likes_layout_group.removeChildren();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.likes_activity)
            {
               _loc1_ = AssetStorage.rsx.popup_theme.create(ClipSprite,"clanLike_activity");
               clip.likes_layout_group.addChild(_loc1_.graphics);
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.likes_dungeonActivity)
            {
               _loc1_ = AssetStorage.rsx.popup_theme.create(ClipSprite,"clanLike_dungeonActivity");
               clip.likes_layout_group.addChild(_loc1_.graphics);
               _loc3_++;
            }
            handler_selectedUpdate(_loc2_.property_selected.value);
            handler_selectableUpdate(_loc2_.property_selectable.value);
            handler_giftCountUpdate(_loc2_.property_giftsReceived.value);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanReceiverGiftRendererClip,"clan_receiver_gift_renderer");
         addChild(clip.graphics);
         clip.checkBox.signal_updateSelectedState.add(handler_checkBoxChange);
      }
      
      private function handler_checkBoxChange(param1:ClipToggleButton) : void
      {
         var _loc2_:ClanGiftStatsVO = data as ClanGiftStatsVO;
         if(_loc2_)
         {
            _loc2_.action_check(clip.checkBox.isSelected);
         }
      }
      
      private function handler_selectedUpdate(param1:Boolean) : void
      {
         clip.checkBox.setIsSelectedSilently(param1);
      }
      
      private function handler_selectableUpdate(param1:Boolean) : void
      {
         clip.checkBox.isEnabled = param1;
      }
      
      private function handler_giftCountUpdate(param1:int) : void
      {
         clip.gift_counter.tf_amount.text = String(param1);
      }
   }
}
