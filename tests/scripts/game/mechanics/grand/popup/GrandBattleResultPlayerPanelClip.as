package game.mechanics.grand.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.model.user.UserInfo;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class GrandBattleResultPlayerPanelClip extends GuiClipNestedContainer
   {
       
      
      public var tf_nickname:ClipLabel;
      
      public var player_portrait:PlayerPortraitClip;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public function GrandBattleResultPlayerPanelClip()
      {
         tf_nickname = new ClipLabel();
         player_portrait = new PlayerPortraitClip();
         clan_icon = new ClanIconWithFrameClip();
         super();
      }
      
      public function set data(param1:UserInfo) : void
      {
         graphics.visible = param1;
         if(param1)
         {
            tf_nickname.text = param1.nickname;
            player_portrait.setData(param1);
            clan_icon.setData(param1.clanInfo,false);
         }
         else
         {
            tf_nickname.text = "?";
            player_portrait.setData(null);
            clan_icon.setData(null,false);
         }
      }
   }
}
