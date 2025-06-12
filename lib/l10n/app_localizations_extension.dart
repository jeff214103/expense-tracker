import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsExtension on AppLocalizations {
  String getCategoryLocalization(String category) {
    switch (category) {
      case 'Housing':
        return category_Housing;
      case 'Transportation':
        return category_Transportation;
      case 'Food':
        return category_Food;
      case 'Utilities':
        return category_Utilities;
      case 'Clothing':
        return category_Clothing;
      case 'Medical/Healthcare':
        return category_MedicalHealthcare;
      case 'Insurance':
        return category_Insurance;
      case 'Household Items/Supplies':
        return category_HouseholdItemsSupplies;
      case 'Personal':
        return category_Personal;
      case 'Education':
        return category_Education;
      case 'Savings':
        return category_Savings;
      case 'Gifts/Donations':
        return category_GiftsDonations;
      case 'Entertainment':
        return category_Entertainment;
      case 'Debt':
        return category_Debt;
      case 'Other':
        return category_Other;
      default:
        return category;
    }
  }

  String getCategorySubcategoryLocalization(
      String category, String subCategory) {
    switch (category) {
      case 'Housing':
        switch (subCategory) {
          case 'Mortgage or rent':
            return category_Housing_MortgageRent;
          case 'Property taxes':
            return category_Housing_PropertyTaxes;
          case 'Household repairs':
            return category_Housing_HouseholdRepairs;
          case 'HOA fees':
            return category_Housing_HOAFees;
          default:
            return subCategory;
        }
      case 'Transportation':
        switch (subCategory) {
          case 'Public transportation':
            return category_Transportation_PublicTransportation;
          case 'Taxi/Uber':
            return category_Transportation_TaxiUber;
          case 'Prepaid card':
            return category_Transportation_PrepaidCard;
          case 'Car payment':
            return category_Transportation_CarPayment;
          case 'Car warranty':
            return category_Transportation_CarWarranty;
          case 'Gas':
            return category_Transportation_Gas;
          case 'Tires':
            return category_Transportation_Tires;
          case 'Maintenance and oil changes':
            return category_Transportation_MaintenanceOilChanges;
          case 'Parking fees':
            return category_Transportation_ParkingFees;
          case 'Repairs':
            return category_Transportation_Repairs;
          case 'Registration and DMV Fees':
            return category_Transportation_RegistrationDMVFees;
          default:
            return subCategory;
        }
      case 'Food':
        switch (subCategory) {
          case 'Groceries':
            return category_Food_Groceries;
          case 'Restaurants':
            return category_Food_Restaurants;
          case 'Takeaway':
            return category_Food_Takeaway;
          case 'From Friend':
            return category_Food_FromFriend;
          case 'Street food':
            return category_Food_StreetFood;
          case 'Delivery':
            return category_Food_Delivery;
          case 'Pet food':
            return category_Food_PetFood;
          default:
            return subCategory;
        }
      case 'Utilities':
        switch (subCategory) {
          case 'Electricity':
            return category_Utilities_Electricity;
          case 'Water':
            return category_Utilities_Water;
          case 'Garbage':
            return category_Utilities_Garbage;
          case 'Phones':
            return category_Utilities_Phones;
          case 'Cable':
            return category_Utilities_Cable;
          case 'Internet':
            return category_Utilities_Internet;
          default:
            return subCategory;
        }
      case 'Clothing':
        switch (subCategory) {
          case 'Adults\' clothing':
            return category_Clothing_AdultsClothing;
          case 'Adults\' shoes':
            return category_Clothing_AdultsShoes;
          case 'Children\'s clothing':
            return category_Clothing_ChildrensClothing;
          case 'Children\'s shoes':
            return category_Clothing_ChildrensShoes;
          default:
            return subCategory;
        }
      case 'Medical/Healthcare':
        switch (subCategory) {
          case 'Primary care':
            return category_MedicalHealthcare_PrimaryCare;
          case 'Dental care':
            return category_MedicalHealthcare_DentalCare;
          case 'Specialty care':
            return category_MedicalHealthcare_SpecialtyCare;
          case 'Urgent care':
            return category_MedicalHealthcare_UrgentCare;
          case 'Medications':
            return category_MedicalHealthcare_Medications;
          case 'Medical devices':
            return category_MedicalHealthcare_MedicalDevices;
          default:
            return subCategory;
        }
      case 'Insurance':
        switch (subCategory) {
          case 'Health insurance':
            return category_Insurance_HealthInsurance;
          case 'Homeowner\'s or renter\'s insurance':
            return category_Insurance_HomeownerRentersInsurance;
          case 'Home warranty or protection plan':
            return category_Insurance_HomeWarrantyProtectionPlan;
          case 'Auto insurance':
            return category_Insurance_AutoInsurance;
          case 'Life insurance':
            return category_Insurance_LifeInsurance;
          case 'Disability insurance':
            return category_Insurance_DisabilityInsurance;
          default:
            return subCategory;
        }
      case 'Household Items/Supplies':
        switch (subCategory) {
          case 'Toiletries':
            return category_HouseholdItemsSupplies_Toiletries;
          case 'Laundry detergent':
            return category_HouseholdItemsSupplies_LaundryDetergent;
          case 'Dishwasher detergent':
            return category_HouseholdItemsSupplies_DishwasherDetergent;
          case 'Cleaning supplies':
            return category_HouseholdItemsSupplies_CleaningSupplies;
          case 'Tools':
            return category_HouseholdItemsSupplies_Tools;
          default:
            return subCategory;
        }
      case 'Personal':
        switch (subCategory) {
          case 'Gym memberships':
            return category_Personal_GymMemberships;
          case 'Haircuts':
            return category_Personal_Haircuts;
          case 'Salon services':
            return category_Personal_SalonServices;
          case 'Cosmetics':
            return category_Personal_Cosmetics;
          case 'Babysitter':
            return category_Personal_Babysitter;
          case 'Subscriptions':
            return category_Personal_Subscriptions;
          default:
            return subCategory;
        }
      case 'Education':
        switch (subCategory) {
          case 'Children\'s college':
            return category_Education_ChildrenCollege;
          case 'Your college':
            return category_Education_YourCollege;
          case 'School supplies':
            return category_Education_SchoolSupplies;
          case 'Books':
            return category_Education_Books;
          case 'Tuition':
            return category_Education_Tuition;
          case 'Exams':
            return category_Education_Exams;
          default:
            return subCategory;
        }
      case 'Savings':
        switch (subCategory) {
          case 'Emergency fund':
            return category_Savings_EmergencyFund;
          case 'Big purchases':
            return category_Savings_BigPurchases;
          case 'Other savings':
            return category_Savings_OtherSavings;
          default:
            return subCategory;
        }
      case 'Gifts/Donations':
        switch (subCategory) {
          case 'Birthday':
            return category_GiftsDonations_Birthday;
          case 'Anniversary':
            return category_GiftsDonations_Anniversary;
          case 'Wedding':
            return category_GiftsDonations_Wedding;
          case 'Christmas':
            return category_GiftsDonations_Christmas;
          case 'Special occasion':
            return category_GiftsDonations_SpecialOccasion;
          case 'Charities':
            return category_GiftsDonations_Charities;
          case 'Sourvenir':
            return category_GiftsDonations_Souvenir;
          default:
            return subCategory;
        }
      case 'Entertainment':
        switch (subCategory) {
          case 'Alcohol and/or bars':
            return category_Entertainment_AlcoholBars;
          case 'Games':
            return category_Entertainment_Games;
          case 'Movies':
            return category_Entertainment_Movies;
          case 'Concerts':
            return category_Entertainment_Concerts;
          case 'Vacations':
            return category_Entertainment_Vacations;
          case 'Subscriptions (Netflix, Amazon, Hulu, etc.)':
            return category_Entertainment_Subscriptions;
          case 'Entertainment':
            return category_Entertainment_Other;
          default:
            return subCategory;
        }
      case 'Debt':
        switch (subCategory) {
          case 'Credit card':
            return category_Debt_CreditCard;
          case 'Personal loans':
            return category_Debt_PersonalLoans;
          case 'Student loans':
            return category_Debt_StudentLoans;
          case 'Other debt payments':
            return category_Debt_OtherDebtPayments;
          default:
            return subCategory;
        }
      case 'Other':
        switch (subCategory) {
          case 'Other expenses':
            return category_Other_OtherExpenses;
          default:
            return subCategory;
        }
      default:
        return subCategory;
    }
  }
}
