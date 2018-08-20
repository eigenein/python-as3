package game.mechanics.titan_arena.popup.trophies
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.model.user.hero.PlayerTitanArenaTrophyData;
   import game.util.DateFormatter;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TitanArenaHallOfFameTrophyRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_date:ClipLabel;
      
      public var tf_place:ClipLabel;
      
      public var icon_container:ClipLayout;
      
      public var bg:GuiClipScale9Image;
      
      public function TitanArenaHallOfFameTrophyRendererClip()
      {
         tf_date = new ClipLabel();
         tf_place = new ClipLabel();
         icon_container = ClipLayout.horizontalBottomCentered(0);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function dispose() : void
      {
         graphics.dispose();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      public function commitData(param1:PlayerTitanArenaTrophyData) : void
      {
         var _loc2_:Date = new Date(param1.week * 1000);
         tf_date.text = DateFormatter.dateToDDMMYYYY(_loc2_);
         tf_place.text = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_PLACE",param1.place);
         icon_container.removeChildren();
         var _loc3_:ClipSprite = AssetStorage.rsx.dialog_titan_arena.create(ClipSprite,"cup_" + param1.cup);
         icon_container.addChild(_loc3_.graphics);
      }
   }
}
