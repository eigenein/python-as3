package game.model.user.specialoffer
{
   public class SpecialOfferIconCollection
   {
       
      
      private var offerData:PlayerSpecialOfferData;
      
      private var icons:Vector.<SpecialOfferIconDescription>;
      
      public function SpecialOfferIconCollection(param1:PlayerSpecialOfferData)
      {
         icons = new Vector.<SpecialOfferIconDescription>();
         super();
         this.offerData = param1;
      }
      
      function add(param1:SpecialOfferIconDescription) : void
      {
         var _loc2_:PlayerSpecialOfferEntry = param1.specialOffer;
         if(offerData.getOffer(_loc2_.id))
         {
            icons.push(param1);
         }
      }
      
      public function getList() : Vector.<SpecialOfferIconDescription>
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = icons.length;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var _loc5_:* = icons[_loc3_];
            icons[_loc3_ - _loc1_] = _loc5_;
            _loc4_ = _loc5_;
            if(!offerData.getOffer(_loc4_.specialOffer.id))
            {
               _loc1_++;
            }
            _loc3_++;
         }
         icons.length = _loc2_ - _loc1_;
         icons.sort(SpecialOfferIconDescription.sort_byPriority);
         return icons.concat();
      }
   }
}
