package game.view.popup.player
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class PlayerProfilePopupClip extends PopupClipBase
   {
       
      
      public var button_avatar:ClipButtonLabeled;
      
      public var button_nickname:ClipButtonLabeled;
      
      public var tf_vip:ClipLabel;
      
      public var portrait:PlayerPortraitClip;
      
      public var grp_hero_lvl:PlayerProfileLabeledNumberClip;
      
      public var grp_id:PlayerProfileLabeledNumberClip;
      
      public var grp_team_level:PlayerProfileLabeledNumberClip;
      
      public var grp_team_xp:PlayerProfileLabeledNumberClip;
      
      public var grp_tiime_zone:PlayerProfileLabeledNumberEditableClip;
      
      public var button_server_list:ClipButtonLabeled;
      
      public var tf_label_server:ClipLabel;
      
      public var tf_server_name:ClipLabel;
      
      public function PlayerProfilePopupClip()
      {
         button_avatar = new ClipButtonLabeled();
         button_nickname = new ClipButtonLabeled();
         tf_vip = new ClipLabel();
         portrait = new PlayerPortraitClip();
         grp_hero_lvl = new PlayerProfileLabeledNumberClip();
         grp_id = new PlayerProfileLabeledNumberClip();
         grp_team_level = new PlayerProfileLabeledNumberClip();
         grp_team_xp = new PlayerProfileLabeledNumberClip();
         grp_tiime_zone = new PlayerProfileLabeledNumberEditableClip();
         button_server_list = new ClipButtonLabeled();
         tf_label_server = new ClipLabel();
         tf_server_name = new ClipLabel();
         super();
      }
   }
}
