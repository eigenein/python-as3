package game.view.gui.components.tooltip
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.LayoutGroup;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.resource.ScrollItemDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.ITooltipView;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.model.user.hero.watch.InventoryItemInfoTooltipDataFactory;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObjectContainer;
   
   public class InventoryItemInfoTooltip extends LayoutGroup implements ITooltipView
   {
       
      
      private var prefix:String;
      
      private var clip:GearTooltipClip;
      
      public function InventoryItemInfoTooltip()
      {
         prefix = ColorUtils.hexToRGBFormat(16777215);
         super();
      }
      
      public function hide() : void
      {
         if(parent && this)
         {
            parent.removeChild(this);
         }
      }
      
      public function placeHint(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:Function = !!param1.tooltipVO?param1.tooltipVO.placeFn:null;
         if(_loc3_ != null)
         {
            _loc3_.apply(this,[param1,param2]);
         }
         else
         {
            placeSelf(param1,param2);
         }
      }
      
      public function placeSelf(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:Point = TooltipLayerMediator.calcPosition(this,param2);
         x = _loc3_.x;
         y = _loc3_.y;
      }
      
      public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = undefined;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         if(param1.tooltipVO.hintData)
         {
            param2.addChild(this);
            _loc4_ = param1.tooltipVO.hintData as InventoryItem;
            clip.tf_item_name.text = _loc4_.name;
            if(_loc4_ is InventoryFragmentItem && _loc4_.item is UnitDescription)
            {
               clip.tf_item_desc.text = InventoryItemInfoTooltipDataFactory.getHeroFragmentDesc(_loc4_.item as HeroDescription);
            }
            else
            {
               clip.tf_item_desc.text = _loc4_.descText;
            }
            _loc8_ = InventoryItemInfoTooltipDataFactory.getInStockText(_loc4_);
            if(_loc8_)
            {
               clip.tf_item_desc.text = _loc8_ + (!!clip.tf_item_desc.text?"\n" + clip.tf_item_desc.text:"");
            }
            _loc9_ = _loc4_.item as GearItemDescription;
            if(!_loc9_)
            {
               _loc6_ = _loc4_.item as ScrollItemDescription;
               if(_loc6_ && _loc6_.gear)
               {
                  _loc9_ = _loc6_.gear;
               }
            }
            if(_loc9_)
            {
               clip.tf_hero_level.visible = true;
               clip.tf_hero_level.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_REQUIRED_LEVEL") + prefix + " " + _loc9_.heroLevel;
            }
            else
            {
               clip.tf_hero_level.visible = false;
            }
            _loc3_ = InventoryItemInfoTooltipDataFactory.getHeroList(_loc4_);
            _loc5_ = clip.hero.length;
            if(_loc3_ && _loc3_.length)
            {
               clip.tf_hero_list_label.text = Translate.translate("UI_INVENTORY_ITEM_INFO_TOOLTIP_HERO_LIST");
               if(_loc3_.length <= 4)
               {
                  clip.hero_plus_count.graphics.visible = false;
               }
               else
               {
                  clip.hero_plus_count.tf_plus_amount.text = "+" + (_loc3_.length - 4);
                  clip.hero_4.graphics.visible = false;
                  clip.hero_plus_count.graphics.visible = true;
                  _loc5_--;
               }
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  if(_loc3_.length > _loc7_)
                  {
                     clip.hero[_loc7_].graphics.visible = true;
                     clip.hero[_loc7_].data = _loc3_[_loc7_];
                  }
                  else
                  {
                     clip.hero[_loc7_].graphics.visible = false;
                  }
                  _loc7_++;
               }
               clip.tf_hero_list_label.visible = true;
               clip.hero_list_container.graphics.visible = true;
            }
            else
            {
               clip.tf_hero_list_label.visible = false;
               clip.hero_list_container.graphics.visible = false;
            }
            clip.tooltip_layout.invalidate();
            clip.tooltip_layout.validate();
            clip.bg.graphics.height = clip.tooltip_layout.graphics.y + clip.tooltip_layout.graphics.height + 20;
            width = clip.graphics.width;
            height = clip.graphics.height;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(GearTooltipClip,"tooltip_gear");
         addChild(clip.graphics);
      }
   }
}
