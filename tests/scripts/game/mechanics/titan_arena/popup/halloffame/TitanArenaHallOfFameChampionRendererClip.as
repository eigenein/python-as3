package game.mechanics.titan_arena.popup.halloffame
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.mechanics.titan_arena.model.TitanArenaHallOfFameUserInfo;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class TitanArenaHallOfFameChampionRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_name:ClipLabel;
      
      public var tf_clan:ClipLabel;
      
      public var tf_server:ClipLabel;
      
      public var portrait:PlayerPortraitClip;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var bg:GuiClipScale9Image;
      
      public function TitanArenaHallOfFameChampionRendererClip()
      {
         tf_name = new ClipLabel();
         tf_clan = new ClipLabel();
         tf_server = new ClipLabel();
         portrait = new PlayerPortraitClip();
         clan_icon = new ClanIconWithFrameClip();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function dispose() : void
      {
         if(clan_icon)
         {
            clan_icon.dispose();
         }
         graphics.dispose();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      public function commitData(param1:TitanArenaHallOfFameUserInfo) : void
      {
         tf_name.text = param1.nickname;
         if(param1.clanInfo)
         {
            tf_clan.text = param1.clanInfo.title;
         }
         tf_server.text = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_SERVER",param1.serverId);
         portrait.setData(param1);
         clan_icon.setData(param1.clanInfo);
      }
   }
}
