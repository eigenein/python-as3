package game.mechanics.clan_war.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.clan_war.model.ClanWarSlotBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import starling.events.Event;
   
   public class ClanWarMapBuildingLabelBase extends GuiClipNestedContainer
   {
       
      
      protected var slotClips:Vector.<ClanWarSlotClip>;
      
      public var tf_header:ClipLabel;
      
      public var layout_teams:ClipLayout;
      
      public var divider_line:GuiClipScale3Image;
      
      public var layout_block:ClipLayout;
      
      public var darkness:ClipSprite;
      
      public function ClanWarMapBuildingLabelBase()
      {
         slotClips = new Vector.<ClanWarSlotClip>();
         tf_header = new ClipLabel(true);
         layout_teams = ClipLayout.horizontalMiddleCentered(3);
         divider_line = new GuiClipScale3Image();
         layout_block = ClipLayout.verticalCenter(12,tf_header,layout_teams);
         darkness = new ClipSprite();
         super();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = slotClips.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            slotClips[_loc2_].dispose();
            _loc2_++;
         }
         layout_block.removeEventListener("resize",handler_resizeLayout);
      }
      
      public function setDataForSlotIndex(param1:int, param2:ClanWarSlotBase) : void
      {
         var _loc3_:* = null;
         var _loc4_:RsxGuiAsset = AssetStorage.rsx.clan_war_map;
         if(param2.isHeroSlot)
         {
            _loc3_ = _loc4_.create(ClanWarSlotClip,"hero_square");
            layout_teams.addChild(_loc3_.graphics);
         }
         else
         {
            _loc3_ = _loc4_.create(ClanWarSlotClip,"titan_square");
            layout_teams.addChild(_loc3_.graphics);
         }
         _loc3_.data = param2;
         slotClips.push(_loc3_);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_teams.width = NaN;
         layout_block.width = NaN;
         layout_block.addEventListener("resize",handler_resizeLayout);
         var _loc2_:VerticalLayout = layout_block.layout as VerticalLayout;
         var _loc3_:int = 18;
         _loc2_.paddingLeft = _loc3_;
         _loc2_.paddingRight = _loc3_;
      }
      
      private function handler_resizeLayout(param1:Event) : void
      {
         layout_block.x = int(-layout_block.width / 2);
         divider_line.graphics.width = layout_block.width;
         divider_line.graphics.x = layout_block.x;
      }
   }
}
