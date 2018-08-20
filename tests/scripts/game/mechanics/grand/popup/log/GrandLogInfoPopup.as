package game.mechanics.grand.popup.log
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.thread.ArenaBattleThread;
   import game.battle.controller.thread.ReplayBattleThread;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.ClipBasedPopup;
   
   public class GrandLogInfoPopup extends ClipBasedPopup
   {
       
      
      protected var clip:GrandLogInfoClip;
      
      protected var replayHandlers:Array;
      
      protected var chatHandlers:Array;
      
      private var mediator:GrandLogInfoPopupMediator;
      
      public function GrandLogInfoPopup(param1:GrandLogInfoPopupMediator)
      {
         replayHandlers = [handler_replay0,handler_replay1,handler_replay2];
         chatHandlers = [handler_chat0,handler_chat1,handler_chat2];
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<ArenaBattleResultValueObject> = mediator.entry.battles;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            TooltipHelper.removeTooltip(clip.battles[_loc1_].button_replay.graphics);
            TooltipHelper.removeTooltip(clip.battles[_loc1_].button_chat.graphics);
            _loc1_++;
         }
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc3_:* = 0;
         super.initialize();
         var _loc4_:Vector.<ArenaBattleResultValueObject> = mediator.entry.battles;
         var _loc5_:int = _loc4_.length;
         if(_loc5_ == 2)
         {
            clip = AssetStorage.rsx.popup_theme.create_dialog_grand_log_info_2_elements();
         }
         else
         {
            clip = AssetStorage.rsx.popup_theme.create_dialog_grand_log_info();
         }
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.addOnce(handler_close);
         var _loc1_:String = Translate.translate("UI_DIALOG_GRAND_LOG_YOUR_TEAM");
         var _loc6_:String = Translate.translate("UI_DIALOG_GRAND_LOG_ENEMY_TEAM");
         if(mediator.entry.isDefensiveBattle)
         {
            clip.tf_attacker.text = _loc6_;
            clip.tf_defender.text = _loc1_;
         }
         else
         {
            clip.tf_attacker.text = _loc1_;
            clip.tf_defender.text = _loc6_;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            setBattleClip(clip.battles[_loc3_],_loc4_[_loc3_],_loc3_);
            _loc3_++;
         }
         var _loc2_:int = clip.battles.length;
         _loc3_ = _loc5_;
         while(_loc3_ < _loc2_)
         {
            clip.battles[_loc3_].graphics.visible = false;
            _loc3_++;
         }
      }
      
      protected function setBattleClip(param1:GrandLogInfoBattleClip, param2:ArenaBattleResultValueObject, param3:int) : void
      {
         param1.block_attacker.team.setUnitTeam(param2.result.attackers);
         param1.block_attacker.tf_victory.visible = param2.win;
         param1.block_attacker.tf_defeat.visible = !param2.win;
         param1.block_defender.team.setUnitTeam(param2.result.defenders);
         param1.block_defender.tf_victory.visible = !param2.win;
         param1.block_defender.tf_defeat.visible = param2.win;
         param1.tf_header.text = Translate.translateArgs("UI_DIALOG_GRAND_LOG_BATTLE",param3 + 1);
         param1.button_replay.signal_click.add(replayHandlers[param3]);
         param1.button_chat.signal_click.add(chatHandlers[param3]);
         clip.battles_layout.addChild(param1.graphics);
         TooltipHelper.addTooltip(param1.button_replay.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_CAMERA_TOOL_TIP")));
         TooltipHelper.addTooltip(param1.button_chat.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_REPLAY_TOOL_TIP")));
      }
      
      protected function startBattleReplay(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:ArenaBattleResultValueObject = mediator.entry.battles[param1];
         if(_loc2_)
         {
            _loc3_ = new ReplayBattleThread(_loc2_.source,mediator.entry.isDefensiveBattle,mediator.entry.attacker,mediator.entry.defender);
            _loc3_.commandResult = _loc2_;
            _loc3_.onComplete.addOnce(handler_battleComplete);
            _loc3_.run();
         }
      }
      
      protected function sendBattleReplay(param1:int) : void
      {
         mediator.sendReplay(mediator.entry.battles[param1],param1);
      }
      
      protected function handler_close() : void
      {
         close();
      }
      
      private function handler_replay0() : void
      {
         startBattleReplay(0);
      }
      
      private function handler_replay1() : void
      {
         startBattleReplay(1);
      }
      
      private function handler_replay2() : void
      {
         startBattleReplay(2);
      }
      
      private function handler_chat0() : void
      {
         sendBattleReplay(0);
      }
      
      private function handler_chat1() : void
      {
         sendBattleReplay(1);
      }
      
      private function handler_chat2() : void
      {
         sendBattleReplay(2);
      }
      
      private function handler_battleComplete(param1:ArenaBattleThread) : void
      {
         Game.instance.screen.hideBattle();
      }
   }
}
