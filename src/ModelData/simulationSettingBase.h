#ifndef _SIMLUTATIONSETTINGBASE_H_
#define _SIMLUTATIONSETTINGBASE_H_

#include "modelDataAPI.h"
#include "DataProperty/DataBase.h"

namespace ModelData
{
	class ModelDataBase;

	class MODELDATAAPI SimulationSettingBase : public DataProperty::DataBase
	{
	public:
		SimulationSettingBase(ModelDataBase* m);
		~SimulationSettingBase() = default;

		QDomElement& writeToProjectFile(QDomDocument* doc, QDomElement* parent) override;
		void readDataFromProjectFile(QDomElement* e) override;

		virtual void dataToStream(QDataStream* datas) override;
	protected:
		ModelDataBase* _modelData{};
	};


}


#endif