package game.mechanics.titan_arena.popup.halloffame
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.mechanics.titan_arena.model.TitanArenaHallOfFameUserInfo;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class TitanArenaHallOfFameBestPlayerRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_name:ClipLabel;
      
      public var tf_place:ClipLabel;
      
      public var portrait:PlayerPortraitClip;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var cup_icon_container:ClipLayout;
      
      public var bg:GuiClipScale9Image;
      
      public function TitanArenaHallOfFameBestPlayerRendererClip()
      {
         tf_name = new ClipLabel();
         tf_place = new ClipLabel();
         portrait = new PlayerPortraitClip();
         clan_icon = new ClanIconWithFrameClip();
         cup_icon_container = ClipLayout.horizontalBottomCentered(0);
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
         var _loc2_:* = null;
         if(param1)
         {
            tf_name.text = param1.nickname;
            tf_place.text = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_PLACE",param1.place);
            cup_icon_container.removeChildren();
            _loc2_ = AssetStorage.rsx.dialog_titan_arena.create(ClipSprite,"cup_" + param1.cup + "_small");
            cup_icon_container.addChild(_loc2_.graphics);
            portrait.setData(param1);
            clan_icon.setData(param1.clanInfo);
         }
      }
   }
}
