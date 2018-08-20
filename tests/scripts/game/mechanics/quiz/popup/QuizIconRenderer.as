package game.mechanics.quiz.popup
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.titan.TitanDescription;
   
   public class QuizIconRenderer extends GuiClipNestedContainer
   {
       
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      public function QuizIconRenderer()
      {
         item_border_image = new GuiClipImage();
         item_image = new GuiClipImage();
         super();
      }
      
      public function setData(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc2_:Array = param1.split(":");
         var _loc6_:String = _loc2_[0];
         var _loc5_:int = _loc2_[1];
         var _loc3_:InventoryItemDescription = null;
         var _loc7_:* = _loc6_;
         if("hero" !== _loc7_)
         {
            if("skill" !== _loc7_)
            {
               if("titan" !== _loc7_)
               {
                  if("artifact" !== _loc7_)
                  {
                     if("inventoryItem_gear" === _loc7_)
                     {
                        _loc3_ = DataStorage.gear.getById(_loc5_) as InventoryItemDescription;
                     }
                  }
                  else
                  {
                     _loc3_ = DataStorage.artifact.getById(_loc5_) as InventoryItemDescription;
                  }
               }
               else
               {
                  _loc3_ = DataStorage.titan.getById(_loc5_) as TitanDescription;
               }
            }
            else
            {
               _loc4_ = DataStorage.skill.getSkillById(_loc5_);
               item_image.image.texture = AssetStorage.skillIcon.getItemTexture(_loc4_);
            }
         }
         else
         {
            _loc3_ = DataStorage.hero.getById(_loc5_) as HeroDescription;
         }
         if(_loc3_)
         {
            item_image.image.texture = AssetStorageUtil.getItemDescTexture(_loc3_);
         }
         item_border_image.image.texture = AssetStorage.rsx.popup_theme.getTexture("SimpleFrame");
      }
   }
}
