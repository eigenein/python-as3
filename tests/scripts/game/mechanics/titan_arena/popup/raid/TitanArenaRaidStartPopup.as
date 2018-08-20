package game.mechanics.titan_arena.popup.raid
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.titan_arena.mediator.raid.TitanArenaRaidStartPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class TitanArenaRaidStartPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanArenaRaidStartPopupMediator;
      
      private var clip:TitanArenaRaidStartPopupClip;
      
      public function TitanArenaRaidStartPopup(param1:TitanArenaRaidStartPopupMediator)
      {
         this.mediator = param1;
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.signal_attackersChanged.remove(handler_attackersChanged);
         mediator.signal_defendersChanged.remove(handler_defendersChanged);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.createClip("dialog_titan_arena",TitanArenaRaidStartPopupClip,"popup_titan_arena_raid_start");
         addChild(clip.graphics);
         clip.title = !!mediator.isFinalStage?Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_TITLE_FINAL"):Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RAID_TITLE",mediator.stage);
         clip.tf_header.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_HEADER");
         clip.tf_attackers_header.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_ATTACKERS");
         clip.tf_defenders_header.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_DEFENDERS");
         clip.tf_attackers_desc.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_ATTACKERS_INFO");
         clip.tf_defenders_desc.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_DEFENDERS_INFO");
         clip.block_defenders_text.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_DEFENDERS_LOCKED");
         clip.button_start.initialize(Translate.translate("UI_DIALOG_MISSION_RAID"),mediator.action_start);
         clip.button_close.signal_click.add(mediator.close);
         centerPopupBy(clip.bg.graphics);
         clip.block_attackers.setLocked(false);
         handler_canEditDefenders();
         clip.block_attackers.button_edit.signal_click.add(mediator.action_changeAttackers);
         clip.block_defenders.button_edit.signal_click.add(mediator.action_changeDefenders);
         mediator.signal_attackersChanged.add(handler_attackersChanged);
         mediator.signal_defendersChanged.add(handler_defendersChanged);
         handler_attackersChanged();
         handler_defendersChanged();
      }
      
      private function handler_canEditDefenders() : void
      {
         var _loc1_:Boolean = mediator.canEditDefenders;
         clip.block_defenders_text.graphics.visible = !_loc1_;
         clip.block_defenders.setLocked(!_loc1_);
      }
      
      private function handler_attackersChanged() : void
      {
         clip.block_attackers.team.setUnitTeam(mediator.attackers);
      }
      
      private function handler_defendersChanged() : void
      {
         clip.block_defenders.team.setUnitTeam(mediator.defenders);
      }
   }
}
