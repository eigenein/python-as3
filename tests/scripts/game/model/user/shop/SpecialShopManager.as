package game.model.user.shop
{
   public class SpecialShopManager
   {
       
      
      private var _model:SpecialShopModel;
      
      private var _controller:SpecialShopController;
      
      public function SpecialShopManager()
      {
         super();
         _model = new SpecialShopModel();
         _controller = new SpecialShopController(this);
      }
      
      public function init(param1:Object) : void
      {
         _controller.init(param1);
      }
      
      public function get model() : SpecialShopModel
      {
         return _model;
      }
      
      public function get controller() : SpecialShopController
      {
         return _controller;
      }
   }
}
