package game.view.popup.hero.slot
{
   import com.progrestar.common.lang.Translate;
   import game.mediator.gui.popup.hero.slot.HeroSlotPopupMediator;
   import game.mediator.gui.popup.inventory.ItemInfoPopupMediator;
   import game.view.popup.inventory.ItemInfoPopup;
   
   public class HeroSlotPopup extends ItemInfoPopup
   {
       
      
      private var _mediator:HeroSlotPopupMediator;
      
      public function HeroSlotPopup(param1:ItemInfoPopupMediator)
      {
         super(param1);
         this._mediator = param1 as HeroSlotPopupMediator;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:Boolean = _mediator.heroLevelAcceptable;
         clip.item_description.tf_green_item_requirements.visible = _loc1_;
         clip.item_description.tf_item_requirements.visible = !_loc1_;
         if(_loc1_)
         {
            clip.item_description.tf_green_item_requirements.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_REQUIRED_LEVEL") + " " + _mediator.heroLevelRequired;
         }
         else
         {
            clip.item_description.tf_item_requirements.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_REQUIRED_LEVEL") + " " + _mediator.heroLevelRequired;
         }
      }
      
      override protected function updateTwoMainButtons() : void
      {
         clip.button_wear.signal_click.clear();
         clip.button_craft.signal_click.clear();
         if(_mediator.itemInserted)
         {
            clip.button_wear.guiClipLabel.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_OK");
            clip.button_wear.glow = false;
            clip.button_wear.signal_click.add(close);
            if(false && _mediator.itemIsEnchantable)
            {
               clip.button_craft.guiClipLabel.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_ENCHANT");
               clip.button_craft.signal_click.add(_mediator.action_enchantItem);
            }
            else
            {
               if(_mediator.itemIsCraftable)
               {
                  clip.current_craft.button_craft.glow = false;
               }
               clip.button_craft.graphics.visible = false;
            }
         }
         else
         {
            if(_mediator.itemIsInsertable)
            {
               clip.button_wear.guiClipLabel.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_INSERT");
               clip.button_wear.signal_click.add(_mediator.action_insertItem);
               clip.button_wear.glow = true;
               clip.current_craft.button_craft.glow = false;
            }
            else
            {
               if(_mediator.itemIsCraftable)
               {
                  clip.current_craft.button_craft.glow = !_mediator.itemOwned && _mediator.itemIsCraftableRightNow;
               }
               clip.button_wear.guiClipLabel.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_OK");
               clip.button_wear.signal_click.add(close);
               clip.button_wear.glow = false;
            }
            if(false && _mediator.itemIsCraftable)
            {
               clip.button_craft.guiClipLabel.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_CRAFT");
               clip.button_craft.signal_click.add(_mediator.action_craftItem);
            }
            else
            {
               clip.button_craft.graphics.visible = false;
            }
         }
      }
   }
}
