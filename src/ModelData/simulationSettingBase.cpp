#include "simulationSettingBase.h"
#include "modelDataBase.h"
#include <QDomElement>
#include <QDomDocument>

namespace ModelData
{
	SimulationSettingBase::SimulationSettingBase(ModelDataBase* m)
		:_modelData(m)
	{
		this->setModuleType(DataProperty::Module_Model);
		this->setID(m->getID());
	}

	QDomElement& SimulationSettingBase::writeToProjectFile(QDomDocument* doc, QDomElement* e)
	{
		DataProperty::DataBase::writeToProjectFile(doc, e);

		return *e;
	}
	void SimulationSettingBase::readDataFromProjectFile(QDomElement* e)
	{
		DataProperty::DataBase::readDataFromProjectFile(e);
	}

	void SimulationSettingBase::dataToStream(QDataStream* datas)
	{
		DataProperty::DataBase::dataToStream(datas);
	}


}