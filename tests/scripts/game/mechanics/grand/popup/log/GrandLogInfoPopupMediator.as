package game.mechanics.grand.popup.log
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.command.rpc.grand.GrandBattleResult;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.chat.sendreplay.SendReplayPopUpMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class GrandLogInfoPopupMediator extends PopupMediator
   {
       
      
      public var entry:GrandBattleResult;
      
      public function GrandLogInfoPopupMediator(param1:Player, param2:GrandBattleResult)
      {
         super(param1);
         this.entry = param2;
      }
      
      public function get playerClan() : Boolean
      {
         return player.clan.clan != null;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new GrandLogInfoPopup(this);
         return _popup;
      }
      
      public function sendReplay(param1:ArenaBattleResultValueObject, param2:int) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = false;
         var _loc4_:* = null;
         if(entry)
         {
            _loc3_ = param1.typeId == player.id;
            if(_loc3_)
            {
               if(entry.attacker)
               {
                  _loc4_ = entry.attacker.nickname;
               }
               else
               {
                  _loc4_ = "?";
               }
            }
            else if(entry.defender)
            {
               _loc4_ = entry.defender.nickname;
            }
            else
            {
               _loc4_ = "?";
            }
            _loc5_ = Translate.translateArgs("UI_DIALOG_GRAND_ARENA_SEND_REPLAY_TEXT",param2 + 1,_loc4_);
            new SendReplayPopUpMediator(player,param1.replayId,_loc5_).open(Stash.click("grand_arena_log_send_replay",_popup.stashParams));
         }
      }
   }
}
