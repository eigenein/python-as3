package game.assets.storage.rsx
{
   import game.mechanics.grand.popup.GrandBattleResultHeaderClip;
   import game.view.popup.fightresult.pve.MissionDefeatPopupClip;
   
   public class DialogBattleDefeatAsset extends RsxGuiAsset
   {
      
      public static var IDENT:String = "dialog_battle_defeat";
       
      
      public function DialogBattleDefeatAsset(param1:*)
      {
         super(param1);
      }
      
      override public function get completed() : Boolean
      {
         return file.completed;
      }
      
      public function create_dialog_defeat() : MissionDefeatPopupClip
      {
         var _loc1_:MissionDefeatPopupClip = new MissionDefeatPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_defeat"));
         return _loc1_;
      }
      
      public function create_defeat_header_background() : GrandBattleResultHeaderClip
      {
         return create(GrandBattleResultHeaderClip,"defeat_header_background");
      }
   }
}
